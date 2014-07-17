/**
    This program is part of the nealbara suite, which is a free software:
    you can redistribute it and/or modify it under the terms 
    of the GNU General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    
    USES
    ====
    
    This is the interface to invoke Nealbara. 
    
    The program (Nealbara) first reads 
    the workflow file, where 
    each stage, its corresponding function, 
    and its requirements are specified.
    
    The next in reading queue are
    the configuration file, and the grammar file,
    supplied by command line arguments. 
    
    It then sends the configuration file,
    as well as grammar file, 
    to the Niarbyl object.
    
    We assume that the first step of the workflow is
    to generate the world, otherwise similar procedure applies.
    
    From the Niarbyl object, 
    the world commands will read off, then executed.
    
    The process forks, 
    and the child starts the FORTRAN world generator, 
    and links it to two fifos before exiting itself.
    
    The parent reads the world generator requierments, 
    which is basically a list of variables, then
    uses the Niarbyl machine to find 
    these from the configuration file
    and writes the world commands to one fifo, 
    as unformatted binary stream.
    The world generator reads these unformatted data, and 
    returns its result, by writing it to the other fifo, then exits.
    
    The parent reads the world, and saves it in its memory.
    
    
    
    
**/








/** imports **/

// tango
import tango.io.Stdout;
// phobos
import std.stdio, core.stdc.stdio, core.stdc.stdlib, std.string;
// niarbyl
import niarbylmachine, nealbara;







/** functions **/







/* main */
void main()
{
    
    
    // setup
    niarbylmachine.hierarchicalReader Reader = new niarbylmachine.hierarchicalReader(1, "stringarr", "string");
										/* 1 : initiate 1D base set to construct fractal branching
										   stringarr : the content of each knot is a string array
										   string : the arc coordinates are given as strings, thus please deal as such
										*/
    
    Reader.initiate("workflow.conf"); 		// target set
    Reader.readFile();				// read it out
    Reader.readTarget();			// set it to a fractal arc
    
    nealbara.nealbaramachine Nealbara = new nealbara.nealbaramachine("world.conf", "world.grmr");
    // nealbara needs to know only the world and its reading grammar
    
    Nealbara.parse_FractalArc_KnotContent!((niarbylmachine.arc!(string, string[]))[])(Reader.fractalSet_sym_1D.arcs);
    
    //niarbylmachine.
    
    // get the problem equation

    // get the associated solver
    
    
    // get the conditions using the data reader
    
    // call the solver
    
    // get results
    
    // format them
    
    // end of story
    
    }