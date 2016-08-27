///Come up with a name for liquids
var name;
switch (irandom(9))
{
    case 0: name = "Gah" break;
    case 1: name = "Kro" break;
    case 2: name = "Bz" break;
    case 3: name = "Ant" break;
    case 4: name = "Iea" break;
    case 5: name = "Izo" break;
    case 6: name = "Iso" break;
    case 7: name = "Di" break;
    case 8: name = "Phe" break;
    case 9: name = "Gry" break;
}
switch (irandom(9))
{
    case 0: return name; break;
    case 1: name = string_insert("man", name, string_length(name) + 1); break;
    case 2: name = string_insert("gee", name, string_length(name) + 1); break;
    case 3: name = string_insert("enec", name, string_length(name) + 1); break;
    case 4: name = string_insert("poroz", name, string_length(name) + 1); break;
    case 5: name = string_insert("mbro", name, string_length(name) + 1); break;
    case 6: name = string_insert("ooj", name, string_length(name) + 1); break;
    case 7: name = string_insert("unu", name, string_length(name) + 1); break;
    case 8: name = string_insert("yt", name, string_length(name) + 1); break;
    case 9: name = string_insert("tod", name, string_length(name) + 1); break;
}
switch (irandom(5))
{
    case 0: return name; break;
    case 1: name = string_insert(" ", name, string_length(name) + 1); break;
    case 2: name = string_insert("'", name, string_length(name) + 1); break;
    case 3: name = string_insert("-", name, string_length(name) + 1); break;
}
switch (irandom(9))
{
    case 0: name = string_insert("har", name, string_length(name) + 1); break;
    case 1: name = string_insert("boz", name, string_length(name) + 1); break;
    case 2: name = string_insert("eti", name, string_length(name) + 1); break;
    case 3: name = string_insert("sha", name, string_length(name) + 1); break;
    case 4: name = string_insert("thro", name, string_length(name) + 1); break;
    case 5: name = string_insert("umbe", name, string_length(name) + 1); break;
    case 6: name = string_insert("aza", name, string_length(name) + 1); break;
    case 7: name = string_insert("dase", name, string_length(name) + 1); break;
    case 8: name = string_insert("yo", name, string_length(name) + 1); break;
    case 9: name = string_insert("phi", name, string_length(name) + 1); break;
}
switch (irandom(5))
{
    case 0: return name; break;
    case 1: name = string_insert("ase", name, string_length(name) + 1); break;
    case 2: name = string_insert(" solution", name, string_length(name) + 1); break;
    case 3: name = string_insert("ii", name, string_length(name) + 1); break;
    case 4: name = string_insert("ite", name, string_length(name) + 1); break;
    case 5: name = string_insert("ium", name, string_length(name) + 1); break;
}

return name;
