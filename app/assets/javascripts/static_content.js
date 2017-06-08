$(document).ready(function () { 
	$('#contact_us_form').validate({
	    rules: {
	    	'contact_us[name]': {required: true,minlength: 2,maxlength: 32},
	    	'contact_us[email]': {required: true,email : true,minlength: 8,maxlength: 32},
	    	'contact_us[mobile_no]': {required: true,number: true,minlength: 10,maxlength: 12},
	    	'contact_us[description]': {required: true,maxlength: 250},	
     	},
	    messages: {
	    	'contact_us[name]': {required: "Please enter name",minlength: 'Name must be at least 2 characters',maxlength: "Name must not be at more than 32 characters"},
			'contact_us[email]': {required: "Please enter email",email : "Please enter an valid email",minlength: 'Email must be at least 8 characters',maxlength: "Email must not be at more than 32 characters"},	
			'contact_us[mobile_no]': {required: "Please enter mobile no",minlength: 'Mobile no must be at least 10 characters',maxlength: "Mobile no must not be at more than 12 characters"},	
			'contact_us[description]': {required: "Please enter description",maxlength: "Description must not be at more than 250 characters"},	
        },
	   submitHandler: function(form) {
	    form.submit();
	   }
	});
	
	$(".add_photo").on("click",function() {
    	$('#myModal').on('hidden.bs.modal', function () {
            $(this).find('form').trigger('reset');
        })
    });

});