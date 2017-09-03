import React from 'react';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import {updatePos} from '../actions/helloWorldActionCreators';

// const position = [51.505, -0.09];
class LocateMap extends React.Component {
    state = {
        hasLocation: false,
        latlng: {
            lat: 51.505,
            lng: -0.09,
        },
    }

    handleClick = () => {
        this.refs.map.leafletElement.locate()
        console.log('clicked')
    }

    handleLocationFound = e => {
        this.setState({
            hasLocation: true,
            latlng: e.latlng,
        })
    }

    constructor(props){
        super()

    }

    render() {
        const marker = this.state.hasLocation
            ? <Marker position={this.state.latlng}>
                <Popup>
                    <span>You are here</span>
                </Popup>
            </Marker>
            : null

        return (
            <Map className="mapBox"
                 center={this.state.latlng}
                 length={4}
                 onClick={this.handleClick}
                 onLocationfound={this.handleLocationFound}
                 ref="map"
                 zoom={13}>
                <TileLayer
                    attribution="&amp;copy <a href=&quot;http://osm.org/copyright&quot;>OpenStreetMap</a> contributors"
                    url="http://{s}.tile.osm.org/{z}/{x}/{y}.png"
                />
                {marker}
            </Map>
        )
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

export default connect(mapStateToProps, mapDispatchToProps)(LocateMap);
// export default connect(mapStateToProps)(SimpleMap);