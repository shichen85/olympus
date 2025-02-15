///@description Expects that the actual value is equal to the expected value
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
function _olympus_acceptance_test_expect_eq(expected, actual) {
	var additional_message = argument_count > 2 ? argument[2] : "";
	_olympus_acceptance_test_throw_result(expected, actual, expected == actual, additional_message);
}

///@description Expects that the structs to equal. Can only compare non-nested structs.
///@param {*} expected
///@param {*} actual
///@param {String} [additional_message]
function _olympus_acceptance_test_expect_struct_eq(expected, actual){
		var keys = variable_struct_get_names(expected);
		for (var i = 0; i < array_length(keys); i++){
			var key = keys[i];
			var expected_value = expected[$ key];
			var actual_value = actual[$ key];
			if (is_string(expected_value) || is_numeric(expected_value) || is_bool(expected_value)){
				_olympus_acceptance_test_expect_eq(expected_value, actual_value, key);
			}
			else{
				_olympus_console_log("Cannot compare non-string, non-boolean, non-number values: " + key);
			}
		}
}

///@description Throws an exception if the provided values do not match
///@param {*} expected
///@param {*} actual
///@param {Bool} matches
///@param {String} [additional_message]
function _olympus_acceptance_test_throw_result(expected, actual, matches) {
	var additional_message = argument_count > 3 ? argument[3] : "";
	if additional_message != ""{
		additional_message += ": ";
	}
	if (!matches){
		var errorMessage = additional_message + "Expected [" + string(expected) + "] Actual [" + string(actual) + "]";
		throw({message: errorMessage, stacktrace: debug_get_callstack()});
	}
}

/// @arg obj
/// @arg [x=0
/// @arg y=0
/// @arg depth=0]
function _olympus_acceptance_test_instance_create() {
	var xx = 0;
	var yy = 0;
	var d = 0;
	if argument_count > 1{
		xx = argument[1];
	}
	if argument_count > 2{
		xx = argument[2];
	}
	if argument_count > 3{
		xx = argument[3];
	}
	return instance_create_depth(xx,yy,d, argument[0]);
}