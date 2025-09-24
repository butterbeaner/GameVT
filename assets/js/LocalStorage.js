export default LocalStorageChecker = {
  mounted() {
    console.log("hook montado")
    this.handleEvent("check_local_storage", () => {
      const desafio = localStorage.getItem("desafio");
      const valores = localStorage.getItem("valores");
      const novalores= localStorage.getItem("novalores");


      if (desafio && valores && novalores) {

        this.pushEvent("desafio_from_local_storage", {
          desafio: desafio.split(","),
          valores: valores.split(","),
          novalores: novalores.split(",")
        });
      } else {
        console.log("noexiste")
        this.pushEvent("no_desafio_in_local_storage", {});
      }
    });

    this.handleEvent("save_to_local_storage", (data) => {
      console.log("save local storage called")
      localStorage.setItem("desafio", data.desafio);
      localStorage.setItem("valores", data.valores);
      localStorage.setItem("novalores", data.novalores);

      console.log("Nuevos datos guardados en localStorage.");
    });
  }
};

