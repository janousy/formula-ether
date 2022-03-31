import Vue from 'vue'
import Vuex from 'vuex'

import dataModule from '@/store/modules/data'
/* eslint-disable semi */

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        data: dataModule
    }
})
