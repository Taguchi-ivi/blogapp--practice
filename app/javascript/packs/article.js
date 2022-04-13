// yarn add jqueryを実行後node配下にjqueryのファイルが作成される
// node配下にあるjqueryを読み込み
import $ from 'jquery'
import axios from 'modules/axios'

import {
    ListenInactiveHeartEvent,
    ListenActiveHeartEvent
} from 'modules/handle_heart'

const handleHeartDisplay = (hasLiked) => {
    if (hasLiked) {
        $('.active-heart').removeClass('hidden')
    } else {
        $('.inactive-heart').removeClass('hidden')
    }
}

const handleCommentForm = () => {
    $('.show-comment-form').on('click', () => {
        $('.show-comment-form').addClass('hidden')
        $('.comment-text-area').removeClass('hidden')
    })
}

const appendNewComment = (comment) => {
    $('.comments-container').append(
        `<div class="article_comment"><p>${comment.content}</p></div>`
    )
}

// document.addEventListener('turbolinks:load', () => {
document.addEventListener('DOMContentLoaded', () => {
    // 確認 => consoleのmessageで行けるはずなのだが、、
    // console.log('aaaaa')
    
    // ↓一回一回処理を止める
    // debugger
    // window.alert('DOM LOADED')
    // $('.article_title').on('click', () => {
    //     // window.alert('CLICKED');
    //     axios.get('/')
    //         .then((response) => {
    //             console.log(response)
    //         })
    // })

    // いいねの表示/非表示対応 非同期処理
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId

    // comment取得
    // axios.get(`/articles/${articleId}/comments`)
    axios.get(`/api/articles/${articleId}/comments`)
    .then((response) => {
        // debugger
        const comments = response.data
        comments.forEach((comment) => {
            appendNewComment(comment)
        })
    })
    .catch((error) => {
        // console.log(error)
        // debugger
        window.alert('失敗')
    })

    handleCommentForm()

    $('.add-comment-button').on('click', () => {
        const content = $('#comment_content').val()
        if (!content) {
            window.alert('コメントを入力してください')
        } else {
            // axios.post(`/articles/${articleId}/comments`, {
            axios.post(`/api/articles/${articleId}/comments`, {
                comment: {content: content}
            })
                .then((res) => {
                    const comment = res.data
                    appendNewComment(comment)
                    $('#comment_content').val('')
                })
        }
    })

    // axios.get(`/articles/${articleId}/like`)
    axios.get(`/api/articles/${articleId}/like`)
        .then((response) => {
            // debugger
            const hasLiked = response.data.hasLiked
            handleHeartDisplay(hasLiked)
        })

        // inactive-heart

        // active-heart

        ListenInactiveHeartEvent(articleId)
        ListenActiveHeartEvent(articleId)

})