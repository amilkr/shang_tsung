import {Socket} from "phoenix"

let logsContainer = $("#logs")
let socket = new Socket("/ws")
socket.connect()
let chan = socket.chan("logs:tsung", {})

chan.on("new_line", payload => {
  logsContainer.append(`<br/>${payload.line}`)
})

chan.join().receive("ok", chan => {
  console.log("Connected to tsung's logs.");
})

let App = {
}

export default App
