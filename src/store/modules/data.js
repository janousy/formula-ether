// Initial state
/* eslint-disable semi */

// race status: 0 for setting bet, 1 for bet is set and waiting, 2 for winner
const moduleState = {
  raceStatus: 0,
  timeElapsed: false,
  timerLessThan30s: false,
  signer: null,
  address: null,
  betIsPlaced: false,
  totalAmountPerTeam: [],
  totalBetSum: 0,
  qualifyingResults: [],
  raceWinningPlayers: [],
  raceWinningTeam: '',
  playersParticipatedInRace: false,
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
  setAddress (state, address) {
    state.address = address
  },
  setBetIsPlaced (state, betIsPlaced) {
    state.betIsPlaced = betIsPlaced;
  },
  setRaceWinningTeam (state, raceWinningTeam) {
    state.raceWinningTeam = raceWinningTeam;
  },
  setRaceWinningPlayers (state, setRaceWinningPlayers) {
    state.setRaceWinningPlayers = setRaceWinningPlayers;
  },
  setTimeElapsed (state, timeElapsed) {
    state.timeElapsed = timeElapsed;
  },
  setTimerLessThan30s (state, timerLessThan30s) {
    state.timerLessThan30s = timerLessThan30s;
  },
  setTotalAmountPerTeam(state, totalAmountPerTeam) {
    state.totalAmountPerTeam = totalAmountPerTeam;
  },
  setTotalBetSum (state, totalBetSum) {
    state.totalBetSum = totalBetSum;
  },
  setQualifyingResults(state, qualifyingResults) {
    state.qualifyingResults = qualifyingResults;
  },
  setPlayersParticipatedInRace(state, playersParticipatedInRace) {
    state.playersParticipatedInRace = playersParticipatedInRace;
  }

};

export default {
  namespaced: true,
  state: moduleState,
  getters,
  actions,
  mutations
}
