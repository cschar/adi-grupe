import React from 'react';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import updatePos from '../actions/helloWorldActionCreators';



const DEFAULT_VIEWPORT = {
    center: [51.505, -0.09],
    zoom: 13,
}

class ViewportExample extends React.Component {
    state = {
        viewport: DEFAULT_VIEWPORT,
    }

    onClickReset = () => {
        this.setState({ viewport: DEFAULT_VIEWPORT })
    }

    onViewportChanged = viewport => {
        this.setState({ viewport })
    }

    render() {
        return (
            <Map
                onClick={this.onClickReset}
                onViewportChanged={this.onViewportChanged}
                viewport={this.state.viewport}>

            </Map>
        )
    }
}


// const position = [51.505, -0.09];
class SimpleMap extends React.Component {

    constructor(props){
        super();

        // this.setState(function(prevState){
        //     viewport: props.viewport
        // })
    }

    componentWillReceiveProps(props){

    }

    @keydown('c')
    method3(event){
        console.log(event)
        this.props.updatePos('down')
    }

    onviewchanged = () => {
        console.log('viewport changed')
    }
// {/*<Map center={this.props.position}*/}
// {/*zoom={6} className="mapBox">*/}
    render() {
        var myview = {
            center: this.props.position,
            zoom: 6
        }
        const DEFAULT_VIEWPORT = {
            center: [51.505, -0.09],
            zoom: 13,
        }

        return (
            <div>
                <Map
                    center={this.props.position}
                    zoom = {4}
                 className="mapBox">

                <Marker position={this.props.position}>
                    <Popup>
                        <span>A pretty CSS3 popup.<br/>Easily customizable.</span>
                    </Popup>
                </Marker>
            </Map>

                <ViewportExample/>
            </div>
        );

    }
}


import { connect } from 'react-redux';
// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => (
    {   name: state.myRed.name,
        position: state.myRed.position
    });

export default connect(mapStateToProps,updatePos)(SimpleMap);