// Initial state
/* eslint-disable semi */

const moduleState = {
  counter: 0,
  raceIsRunning: false,
  signer: null,
  raceWinningTeam: '',
  betIsPlaced: false,
  winners: [],
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
  setSigner (state, signer) {
    state.signer = signer;
  },
  setRaceWinningTeam (state, raceWinningTeam) {
    state.raceWinningTeam = raceWinningTeam;
  },
  setBetIsPlaced (state, betIsPlaced) {
    state.betIsPlaced = betIsPlaced;
  },
  setWinners (state, winners) {
    state.winners = winners;
  }
};

export default {
  namespaced: true,
  state: moduleState,
  getters,
  actions,
  mutations
}
