namespace PrestamosBiblioteca.Dominio;

public sealed class Lector : Persona
{
    public Lector(string codigo, string nombre, string correo, string telefono)
        : base(codigo, nombre, correo)
    {
        Telefono = ValidarTexto(telefono, "El telefono es obligatorio.");
    }

    public string Telefono { get; }

    public override string ObtenerRol() => "Lector";

    public override string ObtenerInformacion() =>
        $"{base.ObtenerInformacion()} | Telefono: {Telefono}";
}
