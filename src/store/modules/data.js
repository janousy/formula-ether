// Initial state
/* eslint-disable semi */

// race status: 0 for setting bet, 1 for bet is set and waiting, 2 for winner
const moduleState = {
  raceStatus: 0,
  signer: null,
  raceWinningTeam: '',
  betIsPlaced: false,
  winners: [],
};

const getters = {};

const actions = {

};

const mutations = {
  setRaceStatus (state, raceStatus) {
    state.raceStatus = raceStatus;
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
