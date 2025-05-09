# Testing out Krista's data

Things to work on
* making grouped color palettes
* making organized facets

Enter your groups where each one is on a separate line with the elemens of the same group separated by commas on the same line, like this:
```
Climate, Fire
Sites
Fish & Wildlife, Plants 
Biophysical Characteristics, Soil Quality
Economics, Navigation
Environmental Justice
Human Health, Air Quality
Way of Life
```
```js
const input = view(Inputs.textarea())
```

### Scheme 10 cat base hex values
${`${d3.schemeCategory10}`.split(",").join(", ")}
### modified scheme values to correspond to agency groups subj_group



```js
let groupingBase = input
let groups = groupingBase.trim().split("\n").map(e=> e.split(", ").map(ee=>ee.trim()))

// now we will choose a base scheme 10 color for each, and then depending on the number of sub groups we will pick out a number of lightness steps to apply
let hexes= d3.schemeCategory10
let col = d3.hsl(hexes[0])
console.log(col)
let colors =[]
let ldelta = .1
// set a l delta, and then have it alternate in increase jumps above or below the base value
let colorGroups = groups.map((group,i)=> {
    let basehex = hexes[i]
    return group.map((ele,j) => {
        let basehsl = d3.hsl(basehex)
        // want the result to be the original color for the first one
        let multiplier = Math.floor(j/2 +1)
        // direction setter pos or negative, so on even numbers it will add in lightness, and for odd, it will subtrack
        let dir = j%2*-1
        console.log(`${basehsl.l} i${i} j${j} ${multiplier} ${dir}`)
        basehsl.l+= ldelta*multiplier*dir
        return basehsl.hex()
    })
})
// flatten both the groups and the colorGroups

let flatGroups = groups.flat()
console.log(flatGroups)
let flatColorGroups = colorGroups.flat()
let together = Array(flatGroups.length).fill(0).map((e,i)=> [flatGroups[i],flatColorGroups[i]])

```
${JSON.stringify(together.join())}


${Inputs.table(f)}
```js
let f = FileAttachment("./data/agency_subject_data.csv").csv({typed:true})
let data = f
let df = aq.from(data)

//${df.getter("subj_group").distinct()}
```

```js

let sub_domain = data.reduce((acc,cur) => {
    let sub = cur.subj_group
    if (acc.indexOf(sub) >=0) {
        return acc
    } else {
        acc.push(sub)
        return acc
    }
},[])
```
Columns
### ${data.columns.join(", ")}
${
    Plot.plot({
        marginBottom:150,
        marginLeft:100,
        color:{domain:flatGroups,range:flatColorGroups,legend:true},
        x:{
            tickRotate:-45,
            label:null,
            domain:flatGroups,
            axis:null},
        marks:[
            Plot.barY(data,{y:"n",x:"subj_group",fx:"tek_term_type",fill:"subj_group"})
        ]
    })
}
But something to consider here is that we are using color as the identity channel for the subj group when we might be able to identify the bars in other ways? Like using the name under the bar?
${
    Plot.plot({
        marginBottom:150,
        marginLeft:100,
        color:{domain:flatGroups,range:flatColorGroups,legend:true},
        x:{
            tickRotate:-45,
            label:null,
            domain:flatGroups,
            },
        marks:[
            Plot.barY(data,{y:"n",x:"subj_group",fx:"tek_term_type",fill:"subj_group"})
        ]
    })
}
But this is usually recommended that we not rotate the text in a visualization

Something to consider, use the text on y, so it's not written at an angle
${
    Plot.plot({
        marginLeft:150,
        marks:[
            Plot.barX(data,{y:"subj_group",x:"n",fx:"tek_term_type"})
        ]
    })
}
But you might say, how can I still provide the general idea of "groupings" like before. I might suggest trying horizontal demarkation lines?

${Plot.plot({
        marginLeft:150,
        y:{domain:flatGroups},
        marks:[
            Plot.ruleY(groups.map(e=>e[e.length-1]).slice(0,-1),{dy:10.25,stroke:"gray",strokeOpacity:0.2}),
            Plot.barX(data,{y:"subj_group",x:"n",fx:"tek_term_type"}),
        ]
})}

And then we can use axis order and horizontal lines to mark our grouping instead of using colors?
