class traversetoExcel():
    def datasettransfer(self,datacol, savepath):
        import openpyxl
        wb = openpyxl.Workbook()
        ws = wb.active
        for i in range(0, len(datacol)):
            ws.cell(row=i + 1, column=1).value = datacol[i]
        wb.save(savepath)