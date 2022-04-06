// race status: 0 for setting bet, 1 for bet is set and waiting, 2 for winner
const moduleState = {
    raceStatus: 0,
    timeElapsed: false,
    preventBetsTimer: false,
};

const getters = {};

const actions = {};

const mutations = {
    setRaceStatus (state, raceStatus) {
        state.raceStatus = raceStatus;
    },
    setTimeElapsed (state, timeElapsed) {
        state.timeElapsed = timeElapsed;
    },
    setPreventBetsTimer (state, preventBetsTimer) {
        state.preventBetsTimer = preventBetsTimer;
    },
};

export default {
    namespaced: true,
    state: moduleState,
    getters,
    actions,
    mutations
}
