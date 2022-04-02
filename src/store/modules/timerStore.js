// race status: 0 for setting bet, 1 for bet is set and waiting, 2 for winner
const moduleState = {
    raceStatus: 0,
    timeElapsed: false,
    timerLessThan30s: false,
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
    setTimerLessThan30s (state, timerLessThan30s) {
        state.timerLessThan30s = timerLessThan30s;
    },
};

export default {
    namespaced: true,
    state: moduleState,
    getters,
    actions,
    mutations
}
