const moduleState = {
  betIsPlaced: false,
  playersParticipatedInRace: false,
  qualifyingResults: [],
  raceWinningPlayers: [],
  raceWinningAmounts: [],
  raceWinningTeam: '',
  totalAmountPerTeam: [],
  totalBetSum: 0,
  raceCounter: 0,
};

const getters = {};

const actions = {};

const mutations = {
  setBetIsPlaced (state, betIsPlaced) {
    state.betIsPlaced = betIsPlaced;
  },
  setPlayersParticipatedInRace(state, playersParticipatedInRace) {
    state.playersParticipatedInRace = playersParticipatedInRace;
  },
  setQualifyingResults(state, qualifyingResults) {
    state.qualifyingResults = qualifyingResults;
  },
  setRaceWinningTeam (state, raceWinningTeam) {
    state.raceWinningTeam = raceWinningTeam;
  },
  setRaceWinningPlayers (state, setRaceWinningPlayers) {
    state.setRaceWinningPlayers = setRaceWinningPlayers;
  },
  setTotalAmountPerTeam(state, totalAmountPerTeam) {
    state.totalAmountPerTeam = totalAmountPerTeam;
  },
  setTotalBetSum (state, totalBetSum) {
    state.totalBetSum = totalBetSum;
  },
  setRaceCounter (state, raceCount) {
    state.raceCounter = raceCount;
  },
};

export default {
  namespaced: true,
  state: moduleState,
  getters,
  actions,
  mutations
}
