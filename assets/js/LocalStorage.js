export default LocalStorageChecker = {
  mounted() {
    console.log("hook montado")
    this.handleEvent("check_local_storage", () => {
      const desafio = localStorage.getItem("desafio");
      const valor1 = localStorage.getItem("valor1");
      const valor2= localStorage.getItem("valor2");
      const valor3 = localStorage.getItem("valor3");
      const novalor1 = localStorage.getItem("novalor1");
      const novalor2 = localStorage.getItem("novalor2");
      const novalor3 = localStorage.getItem("novalor3");

      if (desafio && valor1 && valor2 && valor3 && novalor1 && novalor2 && novalor3) {
        console.log("existen")
        this.pushEvent("desafio_from_local_storage", {
          desafio: desafio,
          valor1: valor1,
          valor2: valor2,
          valor3: valor3,
          novalor1: novalor1,
          novalor2: novalor2,
          novalor3: novalor3
        });
      } else {
        console.log("noexiste")
        this.pushEvent("no_desafio_in_local_storage", {});
      }
    });

    this.handleEvent("save_to_local_storage", (data) => {
      console.log("save local storage called")
      localStorage.setItem("desafio", data.nuevo_desafio);
      localStorage.setItem("valor1", data.nuevo_valor1);
      localStorage.setItem("valor2", data.nuevo_valor2);
      localStorage.setItem("valor3", data.nuevo_valor3);
      localStorage.setItem("novalor1", data.nuevo_novalor1);
      localStorage.setItem("novalor2", data.nuevo_novalor2);
      localStorage.setItem("novalor3", data.nuevo_novalor3);
      console.log("Nuevos datos guardados en localStorage.");
    });
  }
};

