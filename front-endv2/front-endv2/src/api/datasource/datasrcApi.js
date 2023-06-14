import {api,axios} from "@/api/axios";

export function saveDataSrc(payload) {
    return api({
        url:'/datasrc/save_datasrc',
        data:payload,
        method:'post'
    })
}