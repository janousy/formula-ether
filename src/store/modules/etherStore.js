const moduleState = {
    address: null,
    signer: null,
};

const getters = {};

const actions = {};

const mutations = {
    setAddress (state, address) {
        state.address = address
    },
    setSigner (state, signer) {
        state.signer = signer;
    },
};

export default {
    namespaced: true,
    state: moduleState,
    getters,
    actions,
    mutations
}
