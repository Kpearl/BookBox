/**
 * 
 */
function fncGetDate(day){
	var nowDate = new Date();
	var date = nowDate.getTime() - (day * 24 * 60 * 60 * 1000);
	nowDate.setTime(date);
	var year = nowDate.getFullYear();
	var month = nowDate.getMonth() + 1;
	var day = nowDate.getDate();
	
	if(month < 10){
		month = '0' + month;
	}
	if(day < 10){
		day = '0' + day;
	}
	
	return year + '-' + month + '-' + day;
};


