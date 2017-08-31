import {combineReducers} from 'redux';
import {HELLO_WORLD_NAME_UPDATE, MOVE_UPDATE} from '../constants/helloWorldConstants';

//This state is overridden by rails injection in
//Startup
const initState = {
    name: '',
    position: [51.505, -0.09],

};

const myRed = (state = initState, action) => {
    console.log('state is' + state);

    switch (action.type) {
        case HELLO_WORLD_NAME_UPDATE:
            return {
                ...state,
                name: action.text
            }
        case MOVE_UPDATE:
            console.log('move action reducing')
            console.log(state)
            let pos = state.position
            console.log(pos)
            console.log(action.direction)
            if (action.direction == 'up') {
                pos[0] = pos[0] + 1
            } else if (action.direction == 'down') {
                pos[0] = pos[0] - 1
            }
            return {
                ...state,
                position: pos
            }

        default:
            return state;
    }
};

const position = (state = initState, action) => {
    console.log('state is' + state);

    switch (action.type) {
        case MOVE_UPDATE:
            console.log('move action reducing')
            console.log(state)
            let pos = state.position
            console.log(pos)
            console.log(action.direction)
            if (action.direction == 'up') {
                pos[0] = pos[0] + 1
            } else if (action.direction == 'down') {
                pos[0] = pos[0] - 1
            }
            return {
                ...state,
                position: pos
            }

        default:
            return state;
    }
};

// const helloWorldReducer = combineReducers({myRed, position});

const helloWorldReducer = combineReducers({myRed});
export default helloWorldReducer;
