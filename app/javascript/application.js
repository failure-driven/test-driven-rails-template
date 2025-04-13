// Entry point for the build script in your package.json
import "./controllers";
import "@hotwired/turbo-rails";

import HelloReact from "./components/HelloReact";
import mount from "./mount";

mount({
  HelloReact,
});