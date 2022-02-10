import { useState, useEffect } from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

function App() {
  const [inspections, setInspections] = useState([]);

  useEffect(() => {
    fetch("/inspections")
      .then((r) => r.json())
      .then((res) => setInspections(res.data.audits));
  }, []);

  return (
    <BrowserRouter>
      <div className="App">
        <Switch>
          <Route path="/testing">
            <h1>Test Route</h1>
          </Route>
          <Route path="/">
            <ul>
              {inspections.map(audit => <li>{audit.audit_id}</li>)}
            </ul>
          </Route>
        </Switch>
      </div>
    </BrowserRouter>
  );
}

export default App;
