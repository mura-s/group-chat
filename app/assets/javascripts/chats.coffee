# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".my-group").click ->
    # 参加グループ欄
    $(".my-group.active").removeClass("active")
    $(this).addClass("active")
    # グループ編集、抜ける欄
    group_id = $(this).attr("id")
    $(".group-setting,.leave-group").removeClass("disabled")
    $(".group-setting").attr("href", "/groups/#{group_id}/edit")
    $(".leave-group").attr("href", "/groups/#{group_id}/leave")
    # メンバー

    # alert
    $("p.alert").remove()
