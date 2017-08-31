/* eslint-disable import/prefer-default-export */

import { HELLO_WORLD_NAME_UPDATE, MOVE_UPDATE } from '../constants/helloWorldConstants';

export const updateName = (text) => ({
  type: HELLO_WORLD_NAME_UPDATE,
  text,
});


export const updatePos = (direction) => ({
    type: MOVE_UPDATE,
    direction: direction
})