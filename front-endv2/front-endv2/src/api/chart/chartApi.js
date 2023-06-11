import {api} from "@/api/axios";

export function saveChart(payload) {
    return api({
        url:'chart/save',
        data:payload,
        method:"post"
    })
}

export function getAllChart() {
    return api({
        url:'chart/get_all'
    })
}