import React from "react";

const HelloReact = (props) => {
  const handleClick = (event) => {
    event.target.disabled = true;
    event.target.innerText = props.disableWith;
    window.location.href = props.url;
  };

  return (
    <>
      <div>
        <strong>Hello, React!</strong>
      </div>
      <div>
        <button data-testid={props.testid} onClick={handleClick}>
          demos
        </button>
      </div>
    </>
  );
};

export default HelloReact;
