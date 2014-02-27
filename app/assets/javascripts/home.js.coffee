# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$.rails.allowAction = (element) ->
  
  message = element.data('confirm')
  
  return true unless message
  
  $link = element.clone()
   
    .removeAttr('class')
    
    .removeAttr('data-confirm')
    
    .addClass('btn').addClass('btn-primary')
    
    .html("Yes, delete this post.")

  
  modal_html = """
               <div class="modal" id="myModal" style="margin-top: 150px;">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <p><h4>Are you sure you want to delete this post?</h4></p>
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Cancel</a>
                 </div>
               </div>
               """
  $modal_html = $(modal_html)
  
  $modal_html.find('.modal-footer').append($link)
  
  $modal_html.modal()
 
  return false

