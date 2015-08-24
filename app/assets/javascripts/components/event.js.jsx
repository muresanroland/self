var Event = React.createClass({
  propTypes: {
      duration: React.PropTypes.node,
      description: React.PropTypes.string,
      frozen: React.PropTypes.bool,
      key: React.PropTypes.number,
      project: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
          <div>{this.props.project}</div>
          <div>Duration: {this.props.duration}</div>
          <div>Description: {this.props.description}</div>
      </div>
    );
  }
});
