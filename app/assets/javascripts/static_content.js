$(document).ready(function () { 
	$('#contact_us_form').validate({
	    rules: {
	    	'contact_us[name]': {required: true,lettersonly: true,minlength: 2,maxlength: 32},
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

	$('#login_form').validate({
	    rules: {
	    	'user[email]': {required: true,email : true,minlength: 8,maxlength: 32},
	    	'user[password]': {required: true,minlength: 6,maxlength: 12},	
     	},
	    messages: {
			'user[email]': {required: "Please enter email",email : "Please enter an valid email",minlength: 'Email must be at least 8 characters',maxlength: "Email must not be at more than 32 characters"},	
			'user[password]': {required: "Please enter password",minlength: 'Password must be at least 6 characters',maxlength: "Password must not be at more than 12 characters"},	
        },
	   submitHandler: function(form) {
	    form.submit();
	   }
	}); 

	$('#signup_form').validate({
	    rules: {
	    	'user[email]': {required: true,email : true,minlength: 8,maxlength: 32},
	    	'user[password]': {required: true,minlength: 6,maxlength: 12},
	    	'user[password_confirmation]': {required: true,minlength: 6,maxlength: 12,equalTo: "#user_password"},		
     	},
	    messages: {
			'user[email]': {required: "Please enter email",email : "Please enter an valid email",minlength: 'Email must be at least 8 characters',maxlength: "Email must not be at more than 32 characters"},	
			'user[password]': {required: "Please enter password",minlength: 'Password must be at least 6 characters',maxlength: "Password must not be at more than 12 characters"},
			'user[password_confirmation]': {required: "Please enter password confirmation",minlength: 'Password confirmation must be at least 6 characters',maxlength: "Password confirmation must not be at more than 12 characters",equalTo: "Password and password confirmation doesn't match"},			
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

    jQuery.validator.addMethod("lettersonly", function(value, element) {
  		return this.optional(element) || /^[a-zA-Z\s]+$/.test(value);
	}, "Letters only please"); 

});