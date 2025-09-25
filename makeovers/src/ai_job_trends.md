---
theme: dashboard
title: AI job trend
toc: false
---

# AI Job trends 🚀

<!-- Load and transform the data -->

```js
const trends = FileAttachment("data/ai_job_trends_dataset.csv").csv({typed: true});
console.log(trends)
```




<!-- A shared color scale for consistency, sorted by the number of trends -->

```js
const color = Plot.scale({
  color: {
    type: "categorical",
    domain: d3.groupSort(trends, (D) => -D.length, (d) => d.state).filter((d) => d !== "Other"),
    unknown: "var(--theme-foreground-muted)"
  }
});
```

<!-- Cards with big numbers -->

<div class="grid grid-cols-4">
  <div class="card">
    <h2>Industries 🇺🇸</h2>
    <span class="big">${trends.filter((d) => d.stateId === "US").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>Russia 🇷🇺 <span class="muted">/ Soviet Union</span></h2>
    <span class="big">${trends.filter((d) => d.stateId === "SU" || d.stateId === "RU").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>China 🇨🇳</h2>
    <span class="big">${trends.filter((d) => d.stateId === "CN").length.toLocaleString("en-US")}</span>
  </div>
  <div class="card">
    <h2>Other</h2>
    <span class="big">${trends.filter((d) => d.stateId !== "US" && d.stateId !== "SU" && d.stateId !== "RU" && d.stateId !== "CN").length.toLocaleString("en-US")}</span>
  </div>
</div>

```js
//let ai_risk = trends.map(e=> {e["Automation Risk (%)"] > 50})
//    Plot.text(trends, {x:"Gender Diversity (%)",y:"Industry",text: (d,i) => (ai_risk[i]> 50 ? "High risk" :"Low risk")})
Plot.plot({
  marks: [
    Plot.barX(trends, {x: "Gender Diversity (%)", y: "Industry", fill: "steelblue"})
  ]
})
```

<div>
<div class="card">
</div>
</div>
<div>
<div class="card">${Inputs.table(trends)}
</div>
</div>

```js
function launchTimeline(data, {width} = {}) {
  return Plot.plot({
    title: "trends over the years",
    width,
    height: 300,
    y: {grid: true, label: "trends"},
    color: {...color, legend: true},
    marks: [
      Plot.rectY(data, Plot.binX({y: "count"}, {x: "date", fill: "state", interval: "year", tip: true})),
      Plot.ruleY([0])
    ]
  });
}
```

<div class="grid grid-cols-1">
  <div class="card">
    ${resize((width) => launchTimeline(trends, {width}))}
  </div>
</div>

<!-- Plot of launch vehicles -->

```js
function vehicleChart(data, {width}) {
  return Plot.plot({
    title: "Popular launch vehicles",
    width,
    height: 300,
    marginTop: 0,
    marginLeft: 50,
    x: {grid: true, label: "trends"},
    y: {label: null},
    color: {...color, legend: true},
    marks: [
      Plot.rectX(data, Plot.groupY({x: "count"}, {y: "family", fill: "state", tip: true, sort: {y: "-x"}})),
      Plot.ruleX([0])
    ]
  });
}
```

<div class="grid grid-cols-1">
  <div class="card">
    ${resize((width) => vehicleChart(trends, {width}))}
  </div>
</div>

Data: Jonathan C. McDowell, [General Catalog of Artificial Space Objects](https://planet4589.org/space/gcat)
