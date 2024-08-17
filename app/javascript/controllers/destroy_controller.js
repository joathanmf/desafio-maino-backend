import { Controller } from "@hotwired/stimulus";
import { destroy } from "@rails/request.js";
import Swal from "sweetalert2";

export default class extends Controller {
  static targets = ["link"];

  connect() {
    if (this.hasLinkTarget) {
      this.redirectUrl = this.linkTarget.dataset.redirect;
      this.destroyPath = this.linkTarget.dataset.destroyPath;
      this.recordId = this.linkTarget.dataset.recordId;
      this.name = this.linkTarget.dataset.name;
    }
  }

  click(event) {
    event.preventDefault();
    this.confirmDeletion();
  }

  confirmDeletion() {
    Swal.fire({
      title: this.localeTitle(),
      text: this.localeText(),
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: this.localeConfirmButtonText(),
      cancelButtonText: this.localeCancelButtonText(),
      reverseButtons: true,
    }).then((result) => {
      if (result.isConfirmed) {
        this.performDeletion();
      }
    });
  }

  localeTitle() {
    // Garanta que `this.name` não seja undefined
    return document.documentElement.lang === "en"
      ? `Are you sure you want to delete ${this.name || "this record"}?`
      : `Você tem certeza que deseja excluir ${this.name || "este registro"}?`;
  }

  localeText() {
    return document.documentElement.lang === "en"
      ? "This action cannot be undone."
      : "Esta ação não pode ser desfeita.";
  }

  localeConfirmButtonText() {
    return document.documentElement.lang === "en"
      ? "Yes, delete it!"
      : "Sim, excluir!";
  }

  localeCancelButtonText() {
    return document.documentElement.lang === "en" ? "Cancel" : "Cancelar";
  }

  localeCloseButtonText() {
    return document.documentElement.lang === "en" ? "Close" : "Fechar";
  }

  async performDeletion() {
    try {
      const response = await destroy(this.destroyPath, { id: this.recordId });
      if (response.ok) {
        this.successAlert();
      } else {
        this.errorAlert();
      }
    } catch (error) {
      this.errorAlert();
    }
  }

  successAlert() {
    Swal.fire({
      title: this.localeSuccessTitle(),
      text: this.localeSuccessText(),
      icon: "success",
      confirmButtonColor: "#3085d6",
      confirmButtonText: this.localeCloseButtonText(),
    }).then(() => {
      window.location.href = this.redirectUrl;
    });
  }

  errorAlert() {
    Swal.fire({
      title: this.localeErrorTitle(),
      text: this.localeErrorText(),
      icon: "error",
      confirmButtonColor: "#3085d6",
      confirmButtonText: this.localeCloseButtonText(),
    }).then(() => {
      window.location.href = this.redirectUrl;
    });
  }

  localeSuccessTitle() {
    return document.documentElement.lang === "en"
      ? "Record Deleted!"
      : "Registro Excluído!";
  }

  localeSuccessText() {
    return document.documentElement.lang === "en"
      ? `The record ${
          this.name || "this record"
        } has been successfully deleted.`
      : `O registro ${this.name || "este registro"} foi excluído com sucesso.`;
  }

  localeErrorTitle() {
    return document.documentElement.lang === "en"
      ? "Error Occurred!"
      : "Ocorreu um Erro!";
  }

  localeErrorText() {
    return document.documentElement.lang === "en"
      ? "The record could not be deleted."
      : "O registro não pôde ser excluído.";
  }
}
