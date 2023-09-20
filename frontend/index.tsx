/// <reference lib="dom" />
/// <reference lib="dom.iterable" />

import { createRoot } from "react-dom/client";
import { useState } from "react";

async function compute(n: number): Promise<number> {
    const response = await fetch(`/fib/${n}`, {method: "POST"});
    return parseInt(await response.text());
}

function App() {
    const [n, setN] = useState(1);
    const [result, setResult] = useState<number | null>(null);

    return <>
        <h1>N-th Fibonacci number</h1>
        <input type="number" value={ n } onChange={ e => setN(parseInt(e.target.value)) }/>
        <button onClick={ _ => {
            compute(n).then(result => setResult(result));
        } }>Compute</button>
        {result && <h2>Result: {result}</h2>}
    </>;
}

const root = createRoot(document.getElementById("app")!);
root.render(<App/>);
