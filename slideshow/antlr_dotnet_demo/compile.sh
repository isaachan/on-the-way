rm PonishNotation*.cs
rm *~
rm *.tokens
rm antlr_runtime/poni.exe

mono antlr-runtime/Antlr3.exe PonishNotation.g

gmcs -r:antlr-runtime/Antlr3.Runtime.dll,antlr-runtime/Antlr3.Runtime.Debug.dll *.cs -out:antlr-runtime/poni.exe



