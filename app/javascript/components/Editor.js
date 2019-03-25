import React from "react"
import PropTypes from "prop-types"
import SongProEditor from "songpro-editor-component/src/SongProEditor";

class Editor extends React.Component {
  render () {
    return (
        <SongProEditor></SongProEditor>
    );
  }
}

Editor.propTypes = {
  body: PropTypes.string
};

export default Editor
