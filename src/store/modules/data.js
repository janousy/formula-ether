// Initial state
/* eslint-disable semi */

const moduleState = {
  counter: 0,
  raceIsRunning: false,
  account: null,
  raceWinningTeam: ''
};

const getters = {};

const actions = {

};

const mutations = {
  setCounter (state, counter) {
    state.counter = counter
  },
  incrementCounter (state) {
    state.counter += 1
  },
  setRaceIsRunning (state, raceIsRunning) {
    state.raceIsRunning = raceIsRunning;
  },
  setAccount (state, address) {
    state.account = address;
  },
  setRaceWinningTeam (state, raceWinningTeam) {
    state.raceWinningTeam = raceWinningTeam;
  }
};

export default {
  namespaced: true,
  state: moduleState,
  getters,
  actions,
  mutations
}
