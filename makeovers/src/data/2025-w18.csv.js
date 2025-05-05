import {csvParse,csvFormat} from "d3-dsv"
async function text(url) {
    const response = await fetch(url)
    if (!response.ok) throw new Error(`couldn't load ${url} ${response.status}`)
    let t = await response.text()
    console.log(t)
    return t
}
    
const trumpApprovals = await text("https://query.data.world/s/gl2z7shr5ccbdfwlhwdcc5mdvzjd5c?dws=00000")
process.stdout.write(trumpApprovals)