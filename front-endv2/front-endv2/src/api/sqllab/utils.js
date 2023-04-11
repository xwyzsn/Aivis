import {api} from '../axios'

export function getDatasrcMeta(config){
    console.log(config)
    return api.post('/datasrc/meta',config)
}

export function execQuery(config){
    return api.post('/datasrc/execquery',config)
}

export function saveDataset(config){
    return api.post('/datasrc/savedataset',config)
}