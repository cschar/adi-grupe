import PropTypes from 'prop-types';
import React from 'react';
import SimpleMap from './SimpleMap'

const HelloWorld = ({ name, updateName }) => (
  <div>

    <h3>
      Hello, {name}!
    </h3>
    <hr />
      <div className="mapBox">
          <SimpleMap />
      </div>
    <form >
      <label htmlFor="name">
        Say hello to:
      </label>
      <input
        id="name"
        type="text"
        value={name}
        onChange={(e) => updateName(e.target.value)}
      />
    </form>

  </div>
);

HelloWorld.propTypes = {
  name: PropTypes.string.isRequired,
  updateName: PropTypes.func.isRequired,
};

export default HelloWorld;
