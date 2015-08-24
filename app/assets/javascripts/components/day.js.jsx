var Day = React.createClass({

    propTypes: {
        url: React.PropTypes.string,
        pollInterval: React.PropTypes.number
    },

    getInitialState: function() {
        return {date: '', events: []};
    },

    loadEventsFromServer: function() {
        $.ajax({
            url: this.props.url,
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState(data);
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
    },

    componentDidMount: function() {
        this.loadEventsFromServer();
        setInterval(this.loadEventsFromServer, this.props.pollInterval);
    },

    render: function() {
        var nodes = this.state.events.map(function (event) {
            return (
                <Event key={event.id} description={event.description} frozen={event.frozen} duration={event.duration}/>
            );
        });


        return (
            <div>{nodes}</div>
        );
    }
});
