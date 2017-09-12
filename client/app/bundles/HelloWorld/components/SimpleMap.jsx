import React from 'react';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import {updatePos} from '../actions/helloWorldActionCreators';
import ApolloClient, { createNetworkInterface } from 'apollo-client';
import gql from 'graphql-tag';


const myTrackingLayer = new L.FeatureGroup();

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

    onLocationFound =  (e) => {
        console.log("location found")
        let radius = e.accuracy / 2;

        myTrackingLayer.clearLayers();
        let myMarker = L.marker(e.latlng).bindPopup("You are within " + radius + " meters from this point").openPopup();
        let myRadius = L.circle(e.latlng, radius)
        let myRPSRadius = L.circle(e.latlng, {radius:200, color:'green', 'fillOpacity':0.1})
        myTrackingLayer.addLayer(myMarker)
        myTrackingLayer.addLayer(myRadius)
        myTrackingLayer.addLayer(myRPSRadius)
        // this.refs.map.leafletElement.addLayer(myTrackingLayer)
    }

    componentDidMount(){
        // let watch = true ? this.props.watch : false
        this.refs.map.leafletElement.addLayer(myTrackingLayer)
        this.refs.map.leafletElement.on('locationfound', this.onLocationFound)
        if (!this.props.watch){ return}
        if (this.props.watch){
            console.log('watching')

            this.refs.map.leafletElement.locate({setView: true,
                maxZoom: 16,
                watch: this.props.watch,
                enableHighAccuracy: true})
        }

        const csrf = document.head.querySelector("[name=csrf-token]").content;

        const railsNetworkInterface =  createNetworkInterface({
            uri: '/graphql',
            opts: {
                credentials: 'same-origin',
                headers: {
                    'X-CSRF-Token': csrf,
                }
            }
        });

        const client = new ApolloClient({
            networkInterface: railsNetworkInterface});

        console.log("querying")
        client.query({
            query: gql`
    query {
      testField
      lmarkers {
        id
        lat
        lng
      }
    }
  `,
        })
            .then(data => console.log(data))
            .catch(error => console.error(error));

    }

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

            let position = [marker.lat, marker.lng]
            return (
                <Marker key={index + '-setMarker'} icon={getIcon('kerm')}
                        position={position}>
                    <Popup key={index + '-setMarkerPop'} className="popup">
                        <span>custom popup
                        hey ho hey

                        </span>

                    </Popup>
                </Marker>
            )
        }.bind(this));

        let markers = this.props.markers.map(function (marker, index){
            // console.log(marker);
            let position = [parseFloat(marker.lat), parseFloat(marker.lng)]
            let dummyIndex = index.toString() + '-' + marker.id;
            return (
                <Marker key={dummyIndex + '-setMarker'} icon={getIcon(marker.ltype)}
                        position={position}>
                    <Popup key={dummyIndex + '-setMarkerPop'} className="popup">
                        <div>
                            <span key={dummyIndex + 'span-id'}>Lmarker for user {marker.id}</span>
                            <span> ho</span>
                        </div>
                    </Popup>
                </Marker>
            )
        }.bind(this));

        let attr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
            '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
            'Imagery © <a href="http://mapbox.com">Mapbox</a>'
        return (
            <div>
            <button className="btn btn-default" onClick={this.props.updateLmarkersManually}>
            Update Lmarkers from graphql
            </button>
            <Map  className="mapBox"
                  center={this.props.position}
                 onClick={this.handleClick}
                 zoom={10}
                 ref="map">
                <TileLayer

                    url='https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'
                    attribution={attr}
                    id="mapbox.streets"
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
SimpleMap.defaultProps = {
    watch: false
};


const getIcon = function(name){
    let kermIcon = L.icon({
        iconUrl: 'kerm.png',
        iconSize:     [28, 55], // size of the icon
        iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
        popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
    });

    let rockIcon = L.icon({
        iconUrl: 'rock.png',
        // shadowUrl: 'kerm.png',

        iconSize:     [40, 40], // size of the icon
        // shadowSize:   [10, 24], // size of the shadow
        iconAnchor:   [20, 10], // point of the icon which will correspond to marker's location
        // shadowAnchor: [4, 62],  // the same for the shadow
        popupAnchor:  [10, -20] // point from which the popup should open relative to the iconAnchor
    });

    let scissorsIcon = L.icon({
        // iconUrl: 'scissors.png',
        iconUrl: 'scissors2.png',
        // shadowUrl: 'kerm.png',

        iconSize:     [40, 40], // size of the icon
        // shadowSize:   [10, 24], // size of the shadow
        iconAnchor:   [20, 10], // point of the icon which will correspond to marker's location
        // shadowAnchor: [4, 62],  // the same for the shadow
        popupAnchor:  [10, -40] // point from which the popup should open relative to the iconAnchor
    });

    let paperIcon = L.icon({
        iconUrl: 'paper2.png',
        // iconUrl: 'paper2.png',
        // shadowUrl: 'white_square.png',

        iconSize:     [40, 40], // size of the icon
        // shadowSize:   [50, 50], // size of the shadow
        iconAnchor:   [20, 10], // point of the icon which will correspond to marker's location
        // shadowAnchor: [10, 50],  // the same for the shadow
        popupAnchor:  [20, -40] // point from which the popup should open relative to the iconAnchor
    });

    switch (name) {
        case 'rock':
            return rockIcon
        case 'paper'
        :
            return paperIcon
        case 'scissors':
            return scissorsIcon
        default:
            return kermIcon
    }

}


import { connect } from 'react-redux';
import { MOVE_UPDATE, LMARKER_MANUAL_UPDATE } from '../constants/helloWorldConstants';

const mapStateToProps = (state) => (
    {   name: state.myRed.name,
        position: state.myRed.position,
        markers: state.myRed.lmarkers
    });

const mapDispatchToProps = (dispatch) => {
    return {
        updateWithAction : (position) => (
            dispatch(updatePos(position))
        ),
        update : (direction) => dispatch({
            type: MOVE_UPDATE,
            direction: direction
        }),
        updateLmarkersManually: () => dispatch({
            type: LMARKER_MANUAL_UPDATE
        })
    }
};



//TODO: try out poll interval
//http://dev.apollodata.com/react/queries.html#other-graphql-options
export default connect(mapStateToProps, mapDispatchToProps)(SimpleMap);
// export default connect(mapStateToProps)(SimpleMap);