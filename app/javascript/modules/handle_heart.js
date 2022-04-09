import $ from 'jquery'
import axios from 'modules/axios'


const ListenInactiveHeartEvent = (articleId) => {
    $('.inactive-heart').on('click', ()=> {
        // debugger
        axios.post(`/articles/${articleId}/like`)
        .then((response) => {
            // console.log(response)
            if (response.data.status === 'ok'){
                $('.active-heart').removeClass('hidden')
                $('.inactive-heart').addClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
    
}
const ListenActiveHeartEvent = (articleId) => {
    $('.active-heart').on('click', ()=> {
        // debugger
        axios.delete(`/articles/${articleId}/like`)
        .then((response) => {
            // console.log(response)
            if (response.data.status === 'ok'){
                $('.active-heart').addClass('hidden')
                $('.inactive-heart').removeClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })

}

// 名称が右辺と左辺で同じなら省略可能,verによってできないこともあるので注意
export {
    ListenInactiveHeartEvent,
    ListenActiveHeartEvent
}
