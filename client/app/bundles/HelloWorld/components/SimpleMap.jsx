import React from 'react';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import {updatePos} from '../actions/helloWorldActionCreators';

// const position = [51.505, -0.09];
class SimpleMap extends React.Component {

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

    render() {
        return (
            <div>

            <Map center={this.props.position} zoom={6} className="mapBox">
                <TileLayer
                    url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
                    attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                />

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
    {   name: state.name,
        position: state.position
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