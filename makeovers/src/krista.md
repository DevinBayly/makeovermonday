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

${
    Plot.plot({
        y:{axis:null},
        height:120,
        width:350,
        color:{domain:flatGroups,range:flatColorGroups},
    x:{domain:flatGroups,label:null,tickRotate:-45},
    marginBottom:100,
        marks:[
            Plot.barY(plotdata,{
               x:"name",y:"val",fill:"name"
            })
        ]
    })
}


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
let plotdata = flatGroups.map(e=>({name:e,val:2}))
```
the hex codes you'd use are

<pre>
<code>${flatColorGroups.join(", ")}</code>
</pre>


and the list to use for your subj group axes is


<pre>
<code>
${flatGroups.join(", ")} 
</code>
</pre>
