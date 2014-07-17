/**
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/

module nealbara;

/* imports */

// tango
import tango.io.Stdout;
// phobos
import std.stdio, core.stdc.stdio, core.stdc.stdlib, std.string;


// niarbyl
import niarbylmachine;








class nealbaramachine {

	
	niarbylmachine.markupReader worldReader, blob_confReader;
	niarbylmachine.commandParser Parser;
	
	  this(string inputFl, string grammarFl)
	  {
	      worldReader = new niarbylmachine.markupReader;
	      
	      worldReader.initiate(inputFl, grammarFl);
	      worldReader.loadGrammar();
	      worldReader.setGrammar();
	      
	  }



	  ~this() {}
	  
	 
	  void parse_FractalArc_KnotContent(T)(T arcs)
	  {
	      Parser = new niarbylmachine.commandParser;
	      niarbylmachine.parseRes[] cmnds;
	      
	      
	      
	      blob_confReader = new niarbylmachine.markupReader;
	      
	      
	      foreach(A; arcs)
	      {
		foreach(K;A.knots)
		{
		    if(K.type == 1)
		    {
		      cmnds = Parser.parse(K.cnt[0]); // these commands themselves are not tokenized
						      // so, there may be a single entity : knot.cnt[0]
		      if(cmnds.count() == 3)
		      {
				// first one is blob target
				// second one is blob configuration
				// third one is some other command, forget it now
				
				// setup the files
				string blobT = cmnds[0].res;
				string blobC = cmnds[1].res;
				string blobG = cmnds[2].res;
				
				
				blob_confReader.initiate(blobC.chomp(), blobG.chomp());
				blob_confReader.loadGrammar();
				blob_confReader.setGrammar();
				
				// read the blob configuration
				blob_confReader.readTarget("basic world configuration.reqs", "raw");
				
				// decide which variables from the global config file it needs
				// that would be a list
				
				
				// blob_confReader.Results[0].res holds the readout
				// expect a list, a string array
				
				cmnds = Parser.parse(blob_confReader.Results[0].res);
				
				// read those and save those
				// in a struct
				niarbylmachine.result[][] Results;
				
				foreach(c; cmnds)
				{
				    worldReader.readTarget("configure_nealbara."~c.res.chomp(), "raw");
				    
				    Results ~= worldReader.Results;
				    
				    // reset world reader result
				    worldReader.Results = [];
				    
				}
				
				
				foreach(R; Results)
				{
				  foreach(Rr; R)
				    {
				    // we have the results
				    // write on unformatted file
				    
				    
				    
				    }
				    
				}
				
				// make fifos
				
				// program behavior commands
				
				// spawn a process with arguments as fifos
				
				// control returns immediately here
				
				
				// at a serverquery command from the blob,
				// a C file will read the unformatted fifo
				
				// read a third fifo, which is a trigger from the spawned process, 
				// telling you that it ended its job
				
				// read the fifo out, and then continue
				
				
				
				
		      }
			  
		    }
		    else
		    {
		      foreach(K_A_knot; K.arcp.knots)
			{
			    Stdout("hello : ");
			    Stdout(K_A_knot.cnt).nl();
			}
		    }
		  }
		  
	      }
	  }
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  void setupAgents()
	  {
	      
	  }
	  
	  void setdrivers()
	  {
	  }
	  
	  void setTap()
	  {
	  }
	  
	  void fire()
	  {
	  }


}