grammar PonishNotation;

options 
{
    language = CSharp3;
}

@header {
    using System;
    using System.Collections.Generic;
}

@members {
    List<int> stack = new List<int>();
}


public prog:
        exp+
        { Console.WriteLine(stack[0]); }
    ;
  
exp:
        INT { stack.Insert(0, Convert.ToInt32($INT.text)); }
    |   '(' '+' exp exp ')'  { var oper1 = stack[0]; stack.RemoveAt(0); var oper2=stack[0];stack.RemoveAt(0); stack.Insert(0, oper2+oper1);  }
    |   '(' '-' exp exp ')'  { var oper1 = stack[0]; stack.RemoveAt(0); var oper2=stack[0];stack.RemoveAt(0); stack.Insert(0, oper2-oper1);  }
    |   '(' '*' exp exp ')'  { var oper1 = stack[0]; stack.RemoveAt(0); var oper2=stack[0];stack.RemoveAt(0); stack.Insert(0, oper2*oper1);  }
    |   '(' '/' exp exp ')'  { var oper1 = stack[0]; stack.RemoveAt(0); var oper2=stack[0];stack.RemoveAt(0); stack.Insert(0, oper2/oper1);  }        
    ;

INT: '0'..'9'+ ;

WS  :   (' '|'\t')+ {Skip();} ;  
