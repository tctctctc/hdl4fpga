//                                                                            //
// Author(s):                                                                 //
//   Miguel Angel Sagreras                                                    //
//                                                                            //
// Copyright (C) 2015                                                         //
//    Miguel Angel Sagreras                                                   //
//                                                                            //
// This source file may be used and distributed without restriction provided  //
// that this copyright statement is not removed from the file and that any    //
// derivative work contains  the original copyright notice and the associated //
// disclaimer.                                                                //
//                                                                            //
// This source file is free software; you can redistribute it and/or modify   //
// it under the terms of the GNU General Public License as published by the   //
// Free Software Foundation, either version 3 of the License, or (at your     //
// option) any later version.                                                 //
//                                                                            //
// This source is distributed in the hope that it will be useful, but WITHOUT //
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or      //
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for   //
// more details at http://www.gnu.org/licenses/.                              //
//                                                                            //

const cmdline = require('commander');
const commjs  = require('./comm.js');

cmdline
	.option('-l, --link <type>',  'ip       | serial', 'ip')
	.option('-n, --name <name>',  'hostname | ip address | serial port')
	.option('-r, --rid  <id>',    'number')
	.option('-d, --data <value>', 'data');
cmdline.parse(process.argv);


switch(cmdline.link) {
case 'serial':
	commjs.setCommOption('UART');
	break;
case 'ip':
default:
	commjs.setCommOption('TCPIP');
	break;
}

console.log(commjs.getCommOption());
// 
// switch (getCommOption()) {
// case 'serial':
// 	commjs.createUART(uartName, uartOptions);
// 	break;
// case 'tcpip':
// 	commjs.setHost(hostName);
// 	break;
// }
// 
// commjs.send(data);
