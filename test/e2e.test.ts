import puppeteer from "puppeteer";
import { test, expect } from "bun:test";
import { env } from "bun";

test("test fib results", async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    expect(env.URL).not.toBeUndefined();
    await page.goto(env.URL!);
    await page.waitForNetworkIdle();

    const readFib = async (): Promise<number | null> => {
        return await page.evaluate(() => {
            const match = document.body.innerText.match(/Result: (\d+)/);
            return match ? parseInt(match[1]) : null;
        });
    }

    const fib = async (n: number): Promise<number | null> => {
        const oldResult = await readFib();

        await page.focus("input");
        // Clear the input
        for (let i=0; i<5; ++i) await page.keyboard.sendCharacter("Backspace");
        await page.keyboard.type(n.toString());
        await page.click("button");
        await page.waitForFunction(oldResult => {
            const match = document.body.innerText.match(/Result: (\d+)/);
            if (!match) return false;
            return match[1] != oldResult;
        }, {}, oldResult);

        return await readFib();
    };

    expect(await fib(2)).toBe(1);
    expect(await fib(3)).toBe(2);
    expect(await fib(4)).toBe(3);
    expect(await fib(5)).toBe(5);
    expect(await fib(6)).toBe(8);
    expect(await fib(7)).toBe(13);
    expect(await fib(8)).toBe(21);
    expect(await fib(9)).toBe(34);
    expect(await fib(10)).toBe(55);
});
