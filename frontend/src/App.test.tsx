import { render, screen } from "@testing-library/react";
import { expect, test } from "bun:test";
import App from "./App";

test('renders the landing page', () => {
  render(<App/>);
});
