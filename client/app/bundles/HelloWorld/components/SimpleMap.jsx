import React from 'react';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import {updatePos} from '../actions/helloWorldActionCreators';

// const position = [51.505, -0.09];
class SimpleMap extends React.Component {
    state = {
        hasLocation: false,
        latlng: {
            lat: 51.505,
            lng: -0.09,
        },
        markers: []
    };



    handleLocationFound = e => {
        this.setState({
            hasLocation: true,
            latlng: e.latlng,
        })
    }
    componentWillReceiveProps(nextProps){
        this.setState({
            markers: nextProps.markers,
        })
    }

    constructor(props){
        super()

        this.method2 = this.method2.bind(this)
        this.method3 = this.method3.bind(this)
    }

    @keydown('b')
    method2(event){
        console.log(this.props)
        console.log(this.props.position)
        this.props.updateWithAction('down')
    }

    @keydown('c')
    method3(event){
        // method3(event){
        console.log(this.props)
        console.log(this.props.position)
        this.props.update('up')
    };

    handleClick = (evt) => {
        // this.refs.map.leafletElement.locate()
        console.log('clicked')
        console.log(evt)
        console.log(this.refs.map)

        this.setState(function(prevState, props){
            console.log(prevState)
            // markers: prevState.markers.push(evt.latlng)
            let newMarkers = prevState.markers;

            newMarkers.push(evt.latlng)

            return {
                markers: newMarkers
            }
        })
        console.log('state');
        console.log(this.state);
    }

    render() {
        // let setMarkers = [];
        let setMarkers = this.state.markers.map(function (marker, index){
            console.log(marker);
            let position = [marker.lat, marker.lng]
            return (
                <Marker key={index + '-setMarker'} position={position}>
                    <Popup key={index + '-setMarkerPop'} className="popup">
                        <span>custom popup
                        hey ho hey

                        </span>

                    </Popup>
                </Marker>
            )
        }.bind(this));

        let markers = this.props.markers.map(function (marker){
            // console.log(marker);
            let position = [parseFloat(marker.lat), parseFloat(marker.lng)]

            return (
                <Marker key={marker.id} position={position}>
                    <Popup>
                        A popup
                    </Popup>
                </Marker>
            )
        }.bind(this));

        return (
            <div>

            <Map  className="mapBox"
                  center={this.props.position}
                 onClick={this.handleClick}
                 zoom={12}
                 ref="map">
                <TileLayer
                    url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
                    attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                />
                {markers}
                {setMarkers}
                <Marker position={this.props.position}>
                    <Popup>
                        <span>A pretty CSS3 popup.<br/>Easily customizable.</span>
                    </Popup>
                </Marker>
            </Map>

            </div>
        );
    }
}


import { connect } from 'react-redux';
import { MOVE_UPDATE } from '../constants/helloWorldConstants';

const mapStateToProps = (state) => (
    {   name: state.myRed.name,
        position: state.myRed.position,
        markers: state.myRed.markers
    });

const mapDispatchToProps = (dispatch) => {
    return {
        updateWithAction : (position) => (
            dispatch(updatePos(position))
        ),
        update : (direction) => dispatch({
            type: MOVE_UPDATE,
            direction: direction
        })
    }
};

export default connect(mapStateToProps, mapDispatchToProps)(SimpleMap);
// export default connect(mapStateToProps)(SimpleMap);