import Vue from 'vue'
import Vuex from 'vuex'

import raceStoreModule from '@/store/modules/raceStore'
import timerStoreModule from "@/store/modules/timerStore"
import etherStoreModule from "@/store/modules/etherStore";

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        raceStore: raceStoreModule,
        timerStore: timerStoreModule,
        etherStore: etherStoreModule,
    }
})
