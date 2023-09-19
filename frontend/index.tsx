/// <reference lib="dom" />
/// <reference lib="dom.iterable" />

import { createRoot } from "react-dom/client";

function App() {
    return <div>Hello World!</div>;
}

const root = createRoot(document.getElementById("app")!);
root.render(<App/>);
