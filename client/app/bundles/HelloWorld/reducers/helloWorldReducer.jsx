import {combineReducers} from 'redux';
import {HELLO_WORLD_NAME_UPDATE, MOVE_UPDATE, LMARKER_MANUAL_UPDATE} from '../constants/helloWorldConstants';

import ApolloClient, { createNetworkInterface } from 'apollo-client';
import gql from 'graphql-tag';

//This state is overridden by rails injection in
//Startup
const initState = {
    name: '',
    position: [51.505, -0.09],

};

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


const myRed = (state = initState, action) => {
    console.log(`RedReducer triggered w ${action}, pre-reduction state is`);
    console.log(state);

    switch (action.type) {
        case HELLO_WORLD_NAME_UPDATE:
            return {
                ...state,
                name: action.text
            }
        case MOVE_UPDATE:
            console.log('RED: move action reducing')
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
        case LMARKER_MANUAL_UPDATE:
            client.query({
                query: gql`  query{   testField
      lmarkers {
        id
        lat
        lng
      }
    }
  `,
            })
                .then(data => {console.log(data)
                    return {
                        ...state,
                        lmarkers: data.data.lmarkers
                    }
                }
                )
                .catch(error => {
                    console.error(error)
                    return state;
                }

        );



        default:
            return state;
    }
};

// const helloWorldReducer = combineReducers({myRed, position});
const helloWorldReducer = combineReducers({myRed});
export default helloWorldReducer;
