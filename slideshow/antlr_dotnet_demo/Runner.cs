using System;
using System.IO;
using System.Text;
using Antlr.Runtime;
using Antlr.Runtime.Misc;

namespace AntlrDemo.PonishGrammar 
{
    public class Runner
    {
        static void Main(string[] args)
        {
            Stream inputStream = new MemoryStream(Encoding.UTF8.GetBytes(args[0]));

            ANTLRInputStream input = new ANTLRInputStream(inputStream);
            PonishNotationLexer lexer = new PonishNotationLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            PonishNotationParser parser = new PonishNotationParser(tokens);
            parser.prog();
	}
	
    }
}
